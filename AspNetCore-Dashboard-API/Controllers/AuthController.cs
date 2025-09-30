using AspNetCore_Dashboard_API.Models;
using AspNetCore_Dashboard_API.Services;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace AspNetCore_Dashboard_API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly UserService _userService;
        private readonly JwtService _jwtService;

        public AuthController(UserService userService, JwtService jwtService)
        {
            _userService = userService;
            _jwtService = jwtService;
        }

        // 🟢 تسجيل مستخدم جديد
        [HttpPost("signup")]
        public async Task<IActionResult> Signup([FromBody] User request)
        {
            if (string.IsNullOrEmpty(request.Name) ||
                string.IsNullOrEmpty(request.Email) ||
                string.IsNullOrEmpty(request.Password) ||
                request.Password.Length < 8)
            {
                return BadRequest(new { error = "Invalid Input" });
            }

            var existingUser = await _userService.GetByEmailAsync(request.Email);
            if (existingUser != null)
                return BadRequest(new { error = "Email already exists" });

            request.Password = HashPassword(request.Password);

            // توليد توكن جديد مع تمرير userName
            request.Token = _jwtService.GenerateToken(request.Id ?? Guid.NewGuid().ToString(), request.Name);

            await _userService.CreateAsync(request);

            return Ok(new
            {
                user = new { request.Id, request.Name, request.Email },
                token = request.Token
            });
        }

        // 🟢 تسجيل دخول
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] User request)
        {
            var user = await _userService.GetByEmailAsync(request.Email);
            if (user == null || !VerifyPassword(request.Password, user.Password))
                return BadRequest(new { message = "Incorrect email or password" });

            // توليد توكن جديد مع تمرير userName
            var token = _jwtService.GenerateToken(user.Id!, user.Name);
            user.Token = token;
            await _userService.UpdateAsync(user);

            return Ok(new
            {
                user = new { user.Id, user.Name, user.Email },
                token
            });
        }

        // 🟢 تحديث التوكن (Refresh Token)
        [HttpPost("refreshToken")]
        public async Task<IActionResult> RefreshToken()
        {
            var authHeader = Request.Headers["Authorization"].FirstOrDefault();
            if (authHeader == null) return Unauthorized(new { message = "No token" });

            var token = authHeader.Split(" ").Last();
            var principal = _jwtService.ValidateToken(token, ignoreExpiry: true);
            if (principal == null) return Forbid();

            var userId = principal.Claims.First(c => c.Type == "id").Value;
            var user = await _userService.GetByIdAsync(userId);
            if (user == null) return NotFound(new { message = "User not found" });

            // توليد توكن جديد مع تمرير userName
            var newToken = _jwtService.GenerateToken(user.Id!, user.Name);
            user.Token = newToken;
            await _userService.UpdateAsync(user);

            return Ok(new
            {
                user = new { user.Id, user.Name, user.Email },
                token = newToken
            });
        }

        // 🟢 تسجيل خروج
        [HttpPost("logout")]
        public async Task<IActionResult> Logout()
        {
            var authHeader = Request.Headers["Authorization"].FirstOrDefault();
            if (authHeader == null) return Unauthorized(new { message = "No token provided" });

            var token = authHeader.Split(" ").Last();
            var principal = _jwtService.ValidateToken(token);
            if (principal == null) return Forbid();

            var userId = principal.Claims.First(c => c.Type == "id").Value;
            var user = await _userService.GetByIdAsync(userId);
            if (user != null)
            {
                user.Token = null;
                await _userService.UpdateAsync(user);
            }

            return Ok(new { message = "Logged out successfully", userId });
        }

        // 🔐 دوال التشفير
        private string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            return Convert.ToBase64String(sha256.ComputeHash(Encoding.UTF8.GetBytes(password)));
        }

        private bool VerifyPassword(string entered, string hashed) =>
            HashPassword(entered) == hashed;
    }
}
