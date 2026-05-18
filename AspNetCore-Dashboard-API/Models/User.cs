/*
[1]using MongoDB.Bson;
- This allows you to use MongoDB's basic data types, such as:
--- ObjectId → A unique identifier for each document in the collection.
--- BsonDocument → A generic BSON document.
--- BsonValue → The value in the BSON document.

[2]using MongoDB.Bson.Serialization.Attributes;
- This allows you to use MongoDB's serialization/storage attributes, such as:
--- [BsonId]
--- [BsonRepresentation(BsonType.ObjectId)]
--- [BsonElement("Name")]
 */

using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace AspNetCore_Dashboard_API.Models
{

    //------------------------
    //Data Model For User
    //------------------------
    public class User
    {

        //Primary Key
        //The MongoDB He full the Id abput Object Id
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]

        //The ? he men can be Null
        public string? Id { get; set; }

        //Element Name in Monoge DB
        [BsonElement("Name")]
        public string Name { get; set; }

        [BsonElement("Email")]
        public string Email { get; set; }

        [BsonElement("Password")]
        public string Password { get; set; }

        [BsonElement("createdAt")]
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        [BsonElement("token")]
        public string? Token { get; set; }
    }
}
