using System.Net.Http;
using Newtonsoft.Json;

namespace BlooperAPI.Models
{
    public class Message
    {
        public int id { get; set; }
        public int to { get; set; }
        public int from { get; set; }
        public string text { get; set; }

        

        public static async Task<string> Bloop(string text)
        {
            HttpClient client = new HttpClient();
            var blooperList = new List<string>();
            try
            {
                using HttpResponseMessage response = await client.GetAsync("https://localhost:7154/Bloopers");
                response.EnsureSuccessStatusCode();
                string responseBody = await response.Content.ReadAsStringAsync();

                var blooper = JsonConvert.DeserializeObject<List<Blooper>>(responseBody);

                blooper.ForEach(b =>
                {
                    //Console.WriteLine(b.word);
                    blooperList.Add(b.word);
                });
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine(e);
            }

            // Converting text to array of words
            string[] textArray = text.Split(' ');

            // Looping through each word in the array
            int i = 0;
            foreach (var word in textArray)
            {
                int j = 0;
                foreach (var sensitiveWord in blooperList)
                {
                    // Changing to lower case to ensure that the statement is not case sensitive
                    if (word.ToLower() == sensitiveWord.ToLower())
                    {
                        // Creating 'blooped' string with correct length
                        string replacement = "";
                        while (j < sensitiveWord.Length)
                        {
                            replacement += "*";
                            j++;
                        }
                        // Replacing the word in the array with the 'blooped' string
                        textArray[i] = replacement;
                    }
                }
                i++;
            }
            // Returning the array as a string
            return string.Join(" ", textArray);
        }
    }
}
