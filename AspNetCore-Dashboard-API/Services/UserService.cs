using MongoDB.Driver;
using Microsoft.Extensions.Options;
using AspNetCore_Dashboard_API.Models;
using System.Collections.Generic;

namespace AspNetCore_Dashboard_API.Services
{
    public class UserService
    {
        private readonly IMongoCollection<User> _users;

        public UserService(IMongoClient client, IOptions<MongoDBSettings> settings)
        {
            var database = client.GetDatabase(settings.Value.DatabaseName);
            _users = database.GetCollection<User>("Users"); // اسم الكولكشن
        }

        //Get Name
        public List<User> Get() => _users.Find(u => true)
                                        .Project(u => new User { Name = u.Name })
                                        .ToList();

       //Add Name
        public User Create(User user)
        {
            _users.InsertOne(user);
            return user;
        }
    }
}
