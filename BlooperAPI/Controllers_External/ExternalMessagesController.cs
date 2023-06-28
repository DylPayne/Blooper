using BlooperAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;

namespace BlooperAPI.Controllers_External
{
    [ApiController]
    [Route("[controller]")]
    public class ExternalMessagesController
    {
        private readonly IConfiguration Configuration;
        public ExternalMessagesController(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        [HttpPost(Name = "ExternalCreateMessage")]
        public string Post(Message message)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[CreateMessage]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            string bloopedText = Message.Bloop(message.text);

            SqlParameter paramTo = new SqlParameter("@to", message.to);
            SqlParameter paramFrom = new SqlParameter("@from", message.from);
            SqlParameter paramText = new SqlParameter("@text", message.text);

            command.Parameters.Add(paramTo);
            command.Parameters.Add(paramFrom);
            command.Parameters.Add(paramText);

            command.ExecuteNonQuery();

            connection.Close();

            return "Message '" + bloopedText + "' sent to " + message.to;
        }


        [HttpGet (Name = "ExternalGetMessages")]
        public string Get([FromQuery] int to, int from)
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
    }
}
