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

        public Task GetDetectionTask()
        {
            return new Task(DetectAndReportBeats);
        }

        public void DetectAndReportBeats()
        {
            detector.setStarted(true);

            while (true)
            {
                detector.update();
                //if(lastBeat == detector.getLastBeat())

                lastBeat = detector.getLastBeat();

                Thread.Sleep(100);

                if(lastBeat != null)
                {
                    Console.WriteLine($"lastbeat={0} getlastbeat={1}", lastBeat.getMilliseconds(), detector.getLastBeat().getMilliseconds());
                    if (!lastBeat.Equals(detector.getLastBeat()))
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
