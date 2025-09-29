using Microsoft.AspNetCore.Mvc;
using AspNetCore_Dashboard_API.Models;
using AspNetCore_Dashboard_API.Services;
using System.Collections.Generic;

namespace AspNetCore_Dashboard_API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserService _userService;

        public UsersController(UserService userService)
        {
            _userService = userService;
        }

        //Get All Name
        [HttpGet]
        public ActionResult<List<User>> Get() => _userService.Get();

        //Add New Name
        [HttpPost]
        public ActionResult<User> Create(User user)
        {
            _userService.Create(user);
            return CreatedAtAction(nameof(Get), new { id = user.Id }, user);
        }
    }
}
