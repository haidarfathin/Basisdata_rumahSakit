using MySqlConnector;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace hospital_1
{
    public partial class Form5 : Form
    {
        private Form form1;
        private MySqlConnection con;
        public Form5()
        {
            InitializeComponent();
        }

        private void Form5_Load(object sender, EventArgs e)
        {
            var builder = new MySqlConnectionStringBuilder
            {
                Server = "localhost",
                UserID = "root",
                Password = "",
                Database = "hospital",
            };
            con = new MySqlConnection(builder.ConnectionString);
            con.Open();
            using var command = new MySqlCommand("SELECT * FROM doctor_type;", con);
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                comboBox1.Items.Add(String.Concat(reader["id"].ToString(), ". ", reader["type"]));
            }
            con.Close();

            con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_checkup", con);
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dataReader);
            dataGridView1.DataSource = dataTable;
            con.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.form1 = new Form1();
            form1.Show();
            this.Close();
        }

        private void textBox7_TextChanged(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }
    }
}
