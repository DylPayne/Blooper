using BlooperAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;

namespace BlooperAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MessagesController
    {
        private readonly IConfiguration Configuration;
        public MessagesController(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        [HttpPost(Name = "CreateMessage")]
        public string Post([FromBody] Message message)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[CreateMessage]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter to = new SqlParameter("@to", message.to);
            SqlParameter from = new SqlParameter("@from", message.from);
            SqlParameter text = new SqlParameter("@text", message.text);

            command.Parameters.Add(to);
            command.Parameters.Add(from);
            command.Parameters.Add(text);

            command.ExecuteNonQuery();

            connection.Close();

            return "Message '" + message.text + "' sent to " + message.to;
        }
        

        [HttpGet(Name = "GetMessages")]
        public string Get(int to, int from)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[GetMessages]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter paramTo = new SqlParameter("@to", to);
            SqlParameter paramFrom = new SqlParameter("@from", from);
            command.Parameters.Add(paramTo);
            command.Parameters.Add(paramFrom);

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            adapter.Fill(table);
            connection.Close();

            return JsonConvert.SerializeObject(table);
        }

        [HttpPut (Name = "UpdateMessage")]
        public string Put([FromBody] Message message)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[UpdateMessage]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter id = new SqlParameter("@id", message.id);
            SqlParameter to = new SqlParameter("@to", message.to);
            SqlParameter from = new SqlParameter("@from", message.from);
            SqlParameter text = new SqlParameter("@text", message.text);

            command.Parameters.Add(id);
            command.Parameters.Add(to);
            command.Parameters.Add(from);
            command.Parameters.Add(text);

            command.ExecuteNonQuery();

            connection.Close();

            return "Message " + message.id + " updated";
        }

        [HttpDelete (Name = "DeleteMessage")]
        public string Delete(int id)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[DeleteMessage]";
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
