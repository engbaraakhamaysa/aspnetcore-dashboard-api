using MongoDB.Driver;
using Microsoft.Extensions.Options;
using AspNetCore_Dashboard_API.Models;
using System.Collections.Generic;
using System;
using BCrypt.Net;

namespace AspNetCore_Dashboard_API.Services
{
    public class UserService
    {
        private readonly IMongoCollection<User> _users;

        public UserService(IMongoClient client, IOptions<MongoDBSettings> settings)
        {
            var database = client.GetDatabase(settings.Value.DatabaseName);
            _users = database.GetCollection<User>("Users");
        }

        // Get all users (without Password)
        public List<User> Get()
        {
            return _users.Find(u => true)
                         .Project(u => new User
                         {
                             Id = u.Id,
                             Name = u.Name,
                             Email = u.Email,
                             CreatedAt = u.CreatedAt
                         })
                         .ToList();
        }

        // Create new user
        public User Create(User user)
        {
            // Check if Email already exists
            var existingUser = _users.Find(u => u.Email == user.Email).FirstOrDefault();
            if (existingUser != null)
                throw new Exception("Email already exists");

            // Hash the password
            user.Password = BCrypt.Net.BCrypt.HashPassword(user.Password);

            // Set CreatedAt
            user.CreatedAt = DateTime.UtcNow;

            _users.InsertOne(user);
            return user;
        }

        // Optional: Get user by Id
        public User? GetById(string id)
        {
            return _users.Find(u => u.Id == id)
                         .Project(u => new User
                         {
                             Id = u.Id,
                             Name = u.Name,
                             Email = u.Email,
                             CreatedAt = u.CreatedAt
                         })
                         .FirstOrDefault();
        }
    }
}
