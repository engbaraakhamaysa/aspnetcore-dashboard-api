/*
[1]using AspNetCore_Dashboard_API.Models;

- This allows the use of classes in the Models folder, such as User and MongoDBSettings
  Without this line, the code doesn't know about classes defined in Models.

[2]using Microsoft.Extensions.Options;

- Provides tools for working with Configuration (application settings).
- Used here to pass MongoDB settings (MongoDBSettings) securely and flexibly.

[3]using MongoDB.Driver;

- Allows the use of the MongoDB .NET Driver to communicate with the MongoDB database.

- Contains MongoClient, IMongoCollection<T>, and operations such as Find, InsertOneAsync, and ReplaceOneAsync.
 */
using AspNetCore_Dashboard_API.Models;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace AspNetCore_Dashboard_API.Services
{
    //The class contains all the functionality related to handling user data in MongoDB.
    public class UserService
    {

        /*
          - This is a private variable within the class to store the user collection in MongoDB.
          - IMongoCollection<User>: Represents a User table (Collection).
          - Readonly means it can only be set once in the constructor and cannot be changed afterward.
         */
        private readonly IMongoCollection<User> _users;

        //Dependency Injection
        //This constrcter Get info mongo from MongeDbSettings, About Ways IOptions
        /*
         [] Anather Way:using Microsoft.Extensions.Configuration;
              var connectionString = configuration["MongoDBSettings:ConnectionString"];
              var databaseName = configuration["MongoDBSettings:DatabaseName"];
         */
        public UserService(IOptions<MongoDBSettings> settings)
        {
            //get key mongo from file sittngs
            var client = new MongoClient(settings.Value.ConnectionString);
            //get Name DataBase from file setting 
            var database = client.GetDatabase(settings.Value.DatabaseName);


            _users = database.GetCollection<User>("Users");
        }


        //Get Eamil 
        public async Task<User?> GetByEmailAsync(string email) =>
            await _users.Find(u => u.Email == email).FirstOrDefaultAsync();
        //Get Id
        public async Task<User?> GetByIdAsync(string id) =>
            await _users.Find(u => u.Id == id).FirstOrDefaultAsync();


        //Create User
        public async Task CreateAsync(User user) =>
            await _users.InsertOneAsync(user);
        //Update User
        public async Task UpdateAsync(User user) =>
            await _users.ReplaceOneAsync(u => u.Id == user.Id, user);
    }
}
