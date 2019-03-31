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

            LobbyPanel.BringToFront();
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
            lbMenu.Text = "USER INFORMATIONS";
            userInfo1.BringToFront();
            leftPanel.Height = btnUser.Height;
            leftPanel.Top = btnUser.Top;
        }
        //Nút How To Play
        private void button2_Click(object sender, EventArgs e)
        {
            lbMenu.Text = "GUIDE";
            guide1.BringToFront();
            leftPanel.Height = btnInfo.Height;
            leftPanel.Top = btnInfo.Top;
        }
        //Nút Setting
        private void btnConfig_Click(object sender, EventArgs e)
        {
            lbMenu.Text = "SETTING";
            ConfigPanel.BringToFront();
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
            lbMenu.Text = "LOBBY";
            LobbyPanel.BringToFront();
            leftPanel.Height = btnHome.Height;
            leftPanel.Top = btnHome.Top;
        }

        private void leftPanel_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panelRoom_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label2_Click_1(object sender, EventArgs e)
        {

        }

        private void label2_Click_2(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panelConfig_Paint(object sender, PaintEventArgs e)
        {

        }

        private void textBox2_TextChanged_1(object sender, EventArgs e)
        {
                    }

        private void panelConfig_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void lblConfig2_Click(object sender, EventArgs e)
        {

        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void panelGuide_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label7_Click_1(object sender, EventArgs e)
        {

        }

        private void listBox1_SelectedIndexChanged_1(object sender, EventArgs e)
        {

        }

        private void panelGameLobby_Paint(object sender, PaintEventArgs e)
        {

        }

        private void lblLobby2_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click_1(object sender, EventArgs e)
        {

        }

        private void lblLobby4_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void btnRoom1_Click(object sender, EventArgs e)
        {

        }

        private void btnRoom2_Click(object sender, EventArgs e)
        {

        }

        private void btnRoom4_Click(object sender, EventArgs e)
        {

        }

        private void btnSend_Click(object sender, EventArgs e)
        {

        }

        private void lblLobby3_Click(object sender, EventArgs e)
        {

        }

        private void lblConfig1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click_3(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void btnUpdateUser_Click(object sender, EventArgs e)
        {

        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void lblLobby31_Load(object sender, EventArgs e)
        {

        }

        private void guide1_Load(object sender, EventArgs e)
        {

        }
    }
}
