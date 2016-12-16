using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace BeatDetect
{
    public class NodeController
    {
        private static NodeController thisController;
        private string connectionString;
        private Random random = new Random();

        private NodeController(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public static NodeController getInstance(string conn)
        {
            return thisController ?? (thisController = new NodeController(conn));
        }

        private string getRandomColor()
        {
            string result = "";
            int color = random.Next(999);
            if (color < 10)
                result = "00" + (color.ToString());
            else if (color < 100)
                result = "0" + (color.ToString());
            else result = color.ToString();
            return result;
        }

        private string getRGBString()
        {
            return getRandomColor() + getRandomColor() + getRandomColor();
        }

        public void setRandomColor()
        {
            var request = (HttpWebRequest)WebRequest.Create(connectionString + "RGB" + getRGBString());
            string responseString = "ERROR";

            request.Method = "GET";

            HttpWebResponse response = null;

            try
            {
                response = (HttpWebResponse)request.GetResponse();

                responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
            }
            catch (Exception)
            {

            }


            Console.WriteLine(responseString);
        }
    }
}
