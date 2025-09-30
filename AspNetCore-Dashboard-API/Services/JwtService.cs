using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Extensions.Configuration;

namespace AspNetCore_Dashboard_API.Services
{
    /// <summary>
    /// Service for generating and validating JWT tokens.
    /// </summary>
    public class JwtService
    {
        private readonly string _secret;
        private readonly string _issuer;
        private readonly string _audience;

        /// <summary>
        /// Initializes a new instance of the <see cref="JwtService"/> class.
        /// Reads JWT settings from the configuration.
        /// </summary>
        /// <param name="config>The application configuration containing JWT settings.</param>
        public JwtService(IConfiguration config)
        {
            _secret = config["Jwt:Key"];
            _issuer = config["Jwt:Issuer"];
            _audience = config["Jwt:Audience"];
        }

        /// <summary>
        /// Generates a JWT token for a specified user.
        /// </summary>
        /// <param name="userId">The user's unique identifier.</param>
        /// <param name="userName">The user's name.</param>
        /// <param name="expireMinutes">Token expiration time in minutes. Default is 60 minutes.</param>
        /// <returns>A signed JWT token as a string.</returns>
        public string GenerateToken(string userId, string userName, int expireMinutes = 60)
        {
            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, userId),
                new Claim(JwtRegisteredClaimNames.UniqueName, userName),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_secret));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _issuer,
                audience: _audience,
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(expireMinutes),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        /// <summary>
        /// Validates a JWT token and returns the associated claims.
        /// </summary>
        /// <param name="token">The JWT token string to validate.</param>
        /// <param name="ignoreExpiry">Whether to ignore token expiration during validation. Default is false.</param>
        /// <returns>A <see cref="ClaimsPrincipal"/> if the token is valid; otherwise, null.</returns>
        public ClaimsPrincipal? ValidateToken(string token, bool ignoreExpiry = false)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.UTF8.GetBytes(_secret);

            try
            {
                var principal = tokenHandler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidIssuer = _issuer,
                    ValidAudience = _audience,
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ClockSkew = TimeSpan.Zero,
                    ValidateLifetime = !ignoreExpiry
                }, out SecurityToken validatedToken);

                return principal;
            }
            catch
            {
                return null;
            }
        }
    }
}
