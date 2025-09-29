using MongoDB.Bson.Serialization.IdGenerators;

namespace AspNetCore_Dashboard_API
{
    public class MongoDBSettings
    {
        public string ConnectionString { get; set; }
        public string DatabaseName { get; set;}
    }
}
