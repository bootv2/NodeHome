using BeatDetectorCSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace BeatDetect
{
    class BeatReporter
    {
        private BeatDetector detector;
        private static BeatReporter myself;
        private TimeStamp lastBeat;
        private UInt64 amountOfBeats = 0;

        private BeatReporter(BeatDetector detector)
        {
            this.detector = detector;
        }

        public static BeatReporter GetReporterInstance(BeatDetector detector)
        {
            return myself ?? (myself = new BeatReporter(detector));
        }

        //public Task GetDetectionTask()
        //{
            
        //}

        public void DetectAndReportBeats()
        {
            detector.setStarted(true);

            while (true)
            {
                detector.update();

                lastBeat = detector.getLastBeat();

                //I'm sure no song has a bpm higher than 6000 so 
                //it's safe to sleep 10ms before checking if a new beat has been detected
                //This will also save a lot of processing power.
                Thread.Sleep(10);
                if(detector.getLastBeat() != null && lastBeat != null)
                {
                    if (lastBeat.getMilliseconds() != detector.getLastBeat().getMilliseconds())
                        reportLastBeat();
                }
            }
        }

        private void reportLastBeat()
        {
            amountOfBeats++;
            if (amountOfBeats%2 == 0)
            {
                Console.WriteLine("Beat");
            }
            else
            {
                Console.WriteLine("                Beat");
            }
        }
    }
}
