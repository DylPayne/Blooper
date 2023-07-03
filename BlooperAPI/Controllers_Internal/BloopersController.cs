using BlooperAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;

namespace BlooperAPI.Controllers_Internal
{
    [ApiController]
    [Route("[controller]")]
    public class BloopersController
    {
        private readonly IConfiguration Configuration;
        public BloopersController(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        [HttpPost (Name = "CreateBlooper")]
        public string Post([FromBody] string text)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[CreateBlooper]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter paramText = new SqlParameter("@word", text);
            command.Parameters.Add(paramText);

            command.ExecuteNonQuery();

            connection.Close();

            return "Blooper '" + text + "' created";
        }

        [HttpGet(Name = "GetBloopers")]
        public string Get()
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[GetBloopers]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            adapter.Fill(table);

            connection.Close();

            return JsonConvert.SerializeObject(table);
        }

        [HttpPut (Name = "UpdateBlooper")]
        public string Put(int id, string text)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[UpdateBlooper]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter paramId = new SqlParameter("@id", id);
            SqlParameter paramText = new SqlParameter("@word", text);
            command.Parameters.Add(paramId);
            command.Parameters.Add(paramText);

            command.ExecuteNonQuery();

            connection.Close();

            return "Blooper " + id + " updated";
        }

        [HttpDelete (Name = "DeleteBlooper")]
        public string Delete(int id)
        {
            SqlConnection connection = new SqlConnection(Configuration.GetConnectionString("DevConnection"));
            connection.Open();

            string spName = @"[dbo].[DeleteBlooper]";
            SqlCommand command = new SqlCommand(spName, connection);
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter paramId = new SqlParameter("@id", id);
            command.Parameters.Add(paramId);

            command.ExecuteNonQuery();

            connection.Close();

            return "Blooper " + id + " deleted";
        }
    }
}
