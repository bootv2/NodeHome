﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BeatDetectorCSharp;

namespace BeatDetect
{
    public partial class Form1 : Form
    {
        BeatDetector detector = BeatDetector.Instance();
        private BeatReporter reporter;
        private string song = "net.mp3";
        private string connectionString;
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            detector.loadSystem();

            song = textBox1.Text;

            //electronic music most of the time needs a sample size of 2048
            //music like rage against the machine works best with a sample size of 256 but still barely works
            detector.LoadSong(2048, song);
            
            reporter = BeatReporter.GetReporterInstance(detector);
            Console.WriteLine("Instance initialized and loaded!");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            connectionString = textBox2.Text;

            Task reporterTask = reporter.GetDetectionTask();
            reporterTask.Start();
        }
    }
}
