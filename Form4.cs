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
using static System.Windows.Forms.DataFormats;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Button;

namespace hospital_1
{
    public partial class Form4 : Form
    {
        private Form1 form1;
        private MySqlConnection con;
        public Form4()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.form1 = new Form1();
            form1.Show();
            this.Close();
        }

        private void Form4_Load(object sender, EventArgs e)
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
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_obat", con);
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dataReader);
            dataGridView1.DataSource = dataTable;
            con.Close();

        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void search_data_obat(String keyword)
        {

            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_obat WHERE `Nama Obat` LIKE @keyword", this.con);
            dataCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dataReader);
            dataGridView1.DataSource = dataTable;
            this.con.Close();

        }
        private void button7_Click(object sender, EventArgs e)
        {
            this.search_data_obat(textBox6.Text);
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void load_data_obat()
        {
            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_obat", this.con);
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dataReader);
            dataGridView1.DataSource = dataTable;
            this.con.Close();
        }

        private void clear_form()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";

        }

        private void button2_Click(object sender, EventArgs e)
        {
            var nama_obat = textBox1.Text;
            var indikasi = textBox2.Text;
            var kuantitas = textBox3.Text;
            var harga = textBox4.Text;

            this.con.Open();
            MySqlCommand dataCommand;
            if (textBox5.Text == "")
            {

                dataCommand = new MySqlCommand("INSERT INTO drugs (name, diagnose, quantity, price) VALUE(@name, @diagnose, @quantity, @price)", this.con);
            }
            else
            {
                dataCommand = new MySqlCommand("UPDATE drugs SET name = @name, diagnose = @diagnose, quantity = @quantity, price = @price WHERE id = @drug_id", this.con);
                dataCommand.Parameters.AddWithValue("@drug_id", textBox5.Text);
            }
            dataCommand.Parameters.AddWithValue("@name", nama_obat);
            dataCommand.Parameters.AddWithValue("@diagnose", indikasi);
            dataCommand.Parameters.AddWithValue("@quantity", kuantitas);
            dataCommand.Parameters.AddWithValue("@price", harga);
            int affected_rows = dataCommand.ExecuteNonQuery();
            if (affected_rows > 0)
            {
                MessageBox.Show("Berhasil menyimpan data", "Informasi");
            }
            this.con.Close();
            this.clear_form();
            this.load_data_obat();
        }

        private void load_single_obat(int drug_id)
        {
            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM drugs WHERE id = @drug_id", this.con);
            dataCommand.Parameters.AddWithValue("@drug_id", drug_id);
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            if (dataReader.HasRows)
            {
                dataReader.Read();
                textBox1.Text = dataReader.GetString(dataReader.GetOrdinal("name"));
                textBox2.Text = dataReader.GetString(dataReader.GetOrdinal("diagnose"));
                textBox3.Text = dataReader.GetInt32(dataReader.GetOrdinal("quantity")).ToString();
                textBox4.Text = dataReader.GetInt32(dataReader.GetOrdinal("price")).ToString();
            }
            else
            {
                MessageBox.Show("Data Tidak Ditemukan", "Perhatian");
            }

            this.con.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            var rowIndex = dataGridView1.CurrentCell.RowIndex;
            var drug_id = dataGridView1.Rows[rowIndex].Cells[0].Value.ToString();
            textBox5.Text = drug_id;
            this.load_single_obat(Int16.Parse(drug_id));
        }

        private void drop_single_obat(int drug_id)
        {
            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("DELETE FROM drugs WHERE id = @drug_id", this.con);
            try
            {
                dataCommand.Parameters.AddWithValue("@drug_id", drug_id);
                dataCommand.ExecuteNonQuery();
                MessageBox.Show("Berhasil menghapus data", "Berhasil");
            }
            catch (Exception e)
            {
                MessageBox.Show("Gagal menghapus data. Obat pernah melakukan pemeriksaan (checkup).", "Perhatian");
            }
            this.con.Close();
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            var answer = MessageBox.Show("Anda yakin ingin menghapus data ini?", "Perhatian", MessageBoxButtons.YesNo);
            if (answer == DialogResult.Yes)
            {
                var rowIndex = dataGridView1.CurrentCell.RowIndex;
                var drug_id = dataGridView1.Rows[rowIndex].Cells[0].Value.ToString();
                this.drop_single_obat(Int16.Parse(drug_id));
                this.load_data_obat();
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.clear_form();
        }
    }
}
