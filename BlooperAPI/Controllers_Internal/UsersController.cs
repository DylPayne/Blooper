using BlooperAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;

namespace BlooperAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController
    {
        private readonly IConfiguration Configuration;
        public UsersController(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        [HttpPost(Name = "CreateUser")]
        public string Post([FromBody] User user)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[CreateUser]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter username = new SqlParameter("@username", user.username);
            command.Parameters.Add(username);

            command.ExecuteNonQuery();

            connection.Close();

            return "User " + user.username + " created";
        }

        [HttpGet(Name = "GetUsers")]
        public string Get()
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[GetUsers]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            adapter.Fill(table);
            connection.Close();

            return JsonConvert.SerializeObject(table);
        }

        [HttpPut (Name = "UpdateUser")]
        public string Put(int id, string username)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[UpdateUser]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter paramId = new SqlParameter("@id", id);
            SqlParameter paramUsername = new SqlParameter("@username", username);
            command.Parameters.Add(paramId);
            command.Parameters.Add(paramUsername);

            command.ExecuteNonQuery();

            connection.Close();

            return "User " + id + " updated";
        }

        [HttpDelete(Name = "DeleteUser")]
        public string Delete([FromQuery] int id)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[DeleteUser]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter paramId = new SqlParameter("@id", id);
            command.Parameters.Add(paramId);

            command.ExecuteNonQuery();

            connection.Close();

            return "Message " + id + " deleted";
        }
    }
}
