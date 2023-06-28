namespace BlooperAPI.Models
{
    public class Message
    {
        public int id { get; set; }
        public int to { get; set; }
        public int from { get; set; }
        public string text { get; set; }

        

        public static string Bloop(string text)
        {
            // Converting text to array of words
            string[] textArray = text.Split(' ');

            // Looping through each word in the array
            int i = 0;
            foreach (var word in textArray)
            {
                int j = 0;
                foreach (var sensitiveWord in SensitiveWords.sensitiveWordsArray)
                {
                    // Changing to lower case to ensure that the statement is not case sensitive
                    if (word.ToLower() == sensitiveWord.ToLower())
                    {
                        string replacement = "";
                        while (j < sensitiveWord.Length)
                        {
                            replacement += "*";
                            j++;
                        }
                        textArray[i] = replacement;
                    }
                }
                i++;
            }
            return string.Join(" ", textArray);
        }
    }
}
