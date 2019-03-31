using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void logoPanel_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel1_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }
        //Nút User
        private void button3_Click(object sender, EventArgs e)
        {
            lbMenu.Text = "PLAYER INFORMATIONS";
            leftPanel.Height = btnUser.Height;
            leftPanel.Top = btnUser.Top;
        }
        //Nút How To Play
        private void button2_Click(object sender, EventArgs e)
        {
            lbMenu.Text = "BASIC GUIDE";
            leftPanel.Height = btnInfo.Height;
            leftPanel.Top = btnInfo.Top;
        }
        //Nút Setting
        private void btnConfig_Click(object sender, EventArgs e)
        {
            lbMenu.Text = "CONFIGURATION";
            leftPanel.Height = btnConfig.Height;
            leftPanel.Top = btnConfig.Top;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
        //Nút Home
        private void btnHome_Click(object sender, EventArgs e)
        {
            lbMenu.Text = "GAME LOBBY";
            leftPanel.Height = btnHome.Height;
            leftPanel.Top = btnHome.Top;
            panelRoom.Visible = true;
        }

        private void leftPanel_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panelRoom_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
