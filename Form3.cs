using MySqlConnector;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.DataFormats;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace hospital_1
{
    public partial class Form3 : Form
    {
        private Form1 form1;
        private MySqlConnection con;
        public Form3()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.form1 = new Form1();
            form1.Show();
            this.Close();

        }

        private void Form3_Load(object sender, EventArgs e)
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
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_dokter", con);
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dataReader);
            dataGridView1.DataSource = dataTable;
            con.Close();
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void search_data_dokter(String keyword)
        {

            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_dokter WHERE `Nama Lengkap` LIKE @keyword", this.con);
            dataCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dataReader);
            dataGridView1.DataSource = dataTable;
            this.con.Close();

        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.search_data_dokter(textBox5.Text);

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        private void load_data_dokter()
        {
            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM daftar_dokter", this.con);
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
            dateTimePicker1.ResetText();
            radioButton1.Checked = true;
            radioButton2.Checked = false;
            comboBox1.SelectedItem = null;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var nama_lengkap = textBox1.Text;
            var nik = textBox2.Text;
            var tgl_lahir = dateTimePicker1.Value.ToString("yyyy-MM-dd");
            var tmp_lahir = textBox4.Text;

            var gender = "";
            bool isChecked = radioButton1.Checked;
            if (isChecked)
                gender = "M";
            else
                gender = "F";
            string spesialisasi = comboBox1.Text;
            string[] spesialisasi_components = spesialisasi.Split(' ');
            this.con.Open();
            MySqlCommand dataCommand;
            if (textBox3.Text == "")
            {

                dataCommand = new MySqlCommand("INSERT INTO doctors (fullname, nik, birth_date, birth_place, sex, type_id) VALUE(@fullname, @nik, @birth_date, @birth_place, @sex, @type_id)", this.con);
            }
            else
            {
                dataCommand = new MySqlCommand("UPDATE doctors SET fullname = @fullname, nik = @nik, birth_date = @birth_date, birth_place = @birth_place, sex = @sex,type_id = @type_id WHERE id = @doctor_id", this.con);
                dataCommand.Parameters.AddWithValue("@doctor_id", textBox3.Text);
            }
            dataCommand.Parameters.AddWithValue("@fullname", nama_lengkap);
            dataCommand.Parameters.AddWithValue("@nik", nik);
            dataCommand.Parameters.AddWithValue("@birth_date", tgl_lahir);
            dataCommand.Parameters.AddWithValue("@birth_place", tmp_lahir);
            dataCommand.Parameters.AddWithValue("@sex", gender);
            dataCommand.Parameters.AddWithValue("@type_id", spesialisasi_components[0]);
            int affected_rows = dataCommand.ExecuteNonQuery();
            if (affected_rows > 0)
            {
                MessageBox.Show("Berhasil menyimpan data", "Informasi");
            }
            this.con.Close();
            this.clear_form();
            this.load_data_dokter();


        }

        private void load_single_dokter(int doctor_id)
        {
            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("SELECT * FROM doctors WHERE id = @doctor_id", this.con);
            dataCommand.Parameters.AddWithValue("@doctor_id", doctor_id);
            MySqlDataReader dataReader = dataCommand.ExecuteReader();
            if (dataReader.HasRows)
            {
                dataReader.Read();
                textBox1.Text =
                dataReader.GetString(dataReader.GetOrdinal("fullname"));
                textBox2.Text = dataReader.GetString(dataReader.GetOrdinal("nik"));
                var fulldate = dataReader.GetDateOnly("birth_date").ToString("yyyy-MM-dd").Split("-");
                dateTimePicker1.Value = new DateTime(Int32.Parse(fulldate[0]),
                Int32.Parse(fulldate[1]), Int32.Parse(fulldate[2]));
                textBox4.Text =
                dataReader.GetString(dataReader.GetOrdinal("birth_place"));
                if (dataReader.GetString(dataReader.GetOrdinal("sex")) == "M")
                {
                    radioButton1.Checked = true;
                    radioButton2.Checked = false;
                }
                else
                {
                    radioButton1.Checked = false;
                    radioButton2.Checked = true;
                }
                var comboIndex =
                comboBox1.FindString(String.Concat(dataReader.GetInt16(dataReader.GetOrdinal(
                "type_id")).ToString(), "."));
                comboBox1.SelectedIndex = comboIndex;
            }
            else
            {
                MessageBox.Show("Data Tidak Ditemukan", "Perhatian");
            }

            this.con.Close();
        }




        private void button3_Click(object sender, EventArgs e)
        {
            var rowIndex = dataGridView1.CurrentCell.RowIndex;
            var doctor_id = dataGridView1.Rows[rowIndex].Cells[0].Value.ToString();
            textBox3.Text = doctor_id;
            this.load_single_dokter(Int16.Parse(doctor_id));
        }

        private void drop_single_dokter(int doctor_id)
        {
            this.con.Open();
            MySqlCommand dataCommand = new MySqlCommand("DELETE FROM doctors WHERE id = @doctor_id", this.con);
            try
            {
                dataCommand.Parameters.AddWithValue("@doctor_id", doctor_id);
                dataCommand.ExecuteNonQuery();
                MessageBox.Show("Berhasil menghapus data", "Berhasil");
            }
            catch (Exception e)
            {
                MessageBox.Show("Gagal menghapus data. Dokter pernah melakukan pemeriksaan (checkup).", "Perhatian");
            }
            this.con.Close();
        }


        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            var answer = MessageBox.Show("Anda yakin ingin menghapus data ini?", "Perhatian", MessageBoxButtons.YesNo);
            if (answer == DialogResult.Yes)
            {
                var rowIndex = dataGridView1.CurrentCell.RowIndex;
                var doctor_id = dataGridView1.Rows[rowIndex].Cells[0].Value.ToString(); this.drop_single_dokter(Int16.Parse(doctor_id)); this.load_data_dokter();
            }

        }

        private void button5_Click(object sender, EventArgs e)
        {
            clear_form();
        }
    }

}

