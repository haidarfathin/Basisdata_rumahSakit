namespace hospital_1
{
    partial class Form2
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            button6 = new Button();
            button3 = new Button();
            textBox5 = new TextBox();
            textBox3 = new TextBox();
            radioButton2 = new RadioButton();
            radioButton1 = new RadioButton();
            dateTimePicker1 = new DateTimePicker();
            label7 = new Label();
            dataGridView1 = new DataGridView();
            button5 = new Button();
            button4 = new Button();
            label6 = new Label();
            label5 = new Label();
            label4 = new Label();
            label3 = new Label();
            label2 = new Label();
            label1 = new Label();
            button2 = new Button();
            textBox4 = new TextBox();
            textBox2 = new TextBox();
            textBox1 = new TextBox();
            button1 = new Button();
            textBox6 = new TextBox();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            SuspendLayout();
            // 
            // button6
            // 
            button6.Location = new Point(969, 725);
            button6.Margin = new Padding(6, 4, 6, 4);
            button6.Name = "button6";
            button6.Size = new Size(152, 47);
            button6.TabIndex = 52;
            button6.Text = "Cari";
            button6.UseVisualStyleBackColor = true;
            button6.Click += button6_Click_1;
            // 
            // button3
            // 
            button3.Location = new Point(1419, 727);
            button3.Margin = new Padding(6, 4, 6, 4);
            button3.Name = "button3";
            button3.Size = new Size(152, 47);
            button3.TabIndex = 51;
            button3.Text = "Edit";
            button3.UseVisualStyleBackColor = true;
            button3.Click += button3_Click_1;
            // 
            // textBox5
            // 
            textBox5.ForeColor = SystemColors.ButtonShadow;
            textBox5.Location = new Point(680, 727);
            textBox5.Margin = new Padding(6, 4, 6, 4);
            textBox5.Name = "textBox5";
            textBox5.Size = new Size(279, 39);
            textBox5.TabIndex = 50;
            textBox5.Text = "Cari Data Pasien";
            textBox5.TextChanged += textBox5_TextChanged_1;
            // 
            // textBox3
            // 
            textBox3.Location = new Point(422, 70);
            textBox3.Margin = new Padding(6, 4, 6, 4);
            textBox3.Name = "textBox3";
            textBox3.Size = new Size(218, 39);
            textBox3.TabIndex = 49;
            textBox3.Visible = false;
            textBox3.TextChanged += textBox3_TextChanged_1;
            // 
            // radioButton2
            // 
            radioButton2.AutoSize = true;
            radioButton2.Location = new Point(474, 437);
            radioButton2.Margin = new Padding(6, 4, 6, 4);
            radioButton2.Name = "radioButton2";
            radioButton2.Size = new Size(166, 36);
            radioButton2.TabIndex = 47;
            radioButton2.TabStop = true;
            radioButton2.Text = "Perempuan";
            radioButton2.UseVisualStyleBackColor = true;
            radioButton2.CheckedChanged += radioButton2_CheckedChanged;
            // 
            // radioButton1
            // 
            radioButton1.AutoSize = true;
            radioButton1.Location = new Point(243, 433);
            radioButton1.Margin = new Padding(6, 4, 6, 4);
            radioButton1.Name = "radioButton1";
            radioButton1.Size = new Size(132, 36);
            radioButton1.TabIndex = 46;
            radioButton1.TabStop = true;
            radioButton1.Text = "Laki-laki";
            radioButton1.UseVisualStyleBackColor = true;
            radioButton1.CheckedChanged += radioButton1_CheckedChanged;
            // 
            // dateTimePicker1
            // 
            dateTimePicker1.Location = new Point(243, 309);
            dateTimePicker1.Margin = new Padding(6, 4, 6, 4);
            dateTimePicker1.Name = "dateTimePicker1";
            dateTimePicker1.Size = new Size(398, 39);
            dateTimePicker1.TabIndex = 45;
            dateTimePicker1.ValueChanged += dateTimePicker1_ValueChanged;
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Location = new Point(1111, 147);
            label7.Margin = new Padding(6, 0, 6, 0);
            label7.Name = "label7";
            label7.Size = new Size(215, 32);
            label7.TabIndex = 44;
            label7.Text = "Table Daftar Pasien";
            // 
            // dataGridView1
            // 
            dataGridView1.AllowUserToAddRows = false;
            dataGridView1.AllowUserToDeleteRows = false;
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(680, 186);
            dataGridView1.Margin = new Padding(6, 6, 6, 6);
            dataGridView1.MultiSelect = false;
            dataGridView1.Name = "dataGridView1";
            dataGridView1.ReadOnly = true;
            dataGridView1.RowHeadersWidth = 51;
            dataGridView1.RowTemplate.Height = 25;
            dataGridView1.Size = new Size(1042, 525);
            dataGridView1.TabIndex = 43;
            // 
            // button5
            // 
            button5.Location = new Point(241, 572);
            button5.Margin = new Padding(6, 6, 6, 6);
            button5.Name = "button5";
            button5.Size = new Size(139, 49);
            button5.TabIndex = 42;
            button5.Text = "Reset";
            button5.UseVisualStyleBackColor = true;
            button5.Click += button5_Click;
            // 
            // button4
            // 
            button4.Location = new Point(1580, 727);
            button4.Margin = new Padding(6, 6, 6, 6);
            button4.Name = "button4";
            button4.Size = new Size(139, 49);
            button4.TabIndex = 41;
            button4.Text = "Hapus";
            button4.UseVisualStyleBackColor = true;
            button4.Click += button4_Click_1;
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Location = new Point(58, 503);
            label6.Margin = new Padding(6, 0, 6, 0);
            label6.Name = "label6";
            label6.Size = new Size(116, 32);
            label6.TabIndex = 40;
            label6.Text = "Pekerjaan";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(58, 439);
            label5.Margin = new Padding(6, 0, 6, 0);
            label5.Name = "label5";
            label5.Size = new Size(159, 32);
            label5.TabIndex = 39;
            label5.Text = "Jenis Kelamin";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(58, 378);
            label4.Margin = new Padding(6, 0, 6, 0);
            label4.Name = "label4";
            label4.Size = new Size(151, 32);
            label4.TabIndex = 38;
            label4.Text = "Tempat Lahir";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(58, 318);
            label3.Margin = new Padding(6, 0, 6, 0);
            label3.Name = "label3";
            label3.Size = new Size(154, 32);
            label3.TabIndex = 37;
            label3.Text = "Tanggal Lahir";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(58, 256);
            label2.Margin = new Padding(6, 0, 6, 0);
            label2.Name = "label2";
            label2.Size = new Size(157, 32);
            label2.TabIndex = 36;
            label2.Text = "NIK (No. KTP)";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(58, 192);
            label1.Margin = new Padding(6, 0, 6, 0);
            label1.Name = "label1";
            label1.Size = new Size(174, 32);
            label1.TabIndex = 35;
            label1.Text = "Nama Lengkap";
            // 
            // button2
            // 
            button2.Location = new Point(422, 572);
            button2.Margin = new Padding(6, 6, 6, 6);
            button2.Name = "button2";
            button2.Size = new Size(221, 49);
            button2.TabIndex = 34;
            button2.Text = "Simpan";
            button2.UseVisualStyleBackColor = true;
            button2.Click += button2_Click_1;
            // 
            // textBox4
            // 
            textBox4.Location = new Point(243, 371);
            textBox4.Margin = new Padding(6, 6, 6, 6);
            textBox4.Name = "textBox4";
            textBox4.Size = new Size(398, 39);
            textBox4.TabIndex = 33;
            textBox4.TextChanged += textBox4_TextChanged;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(243, 247);
            textBox2.Margin = new Padding(6, 6, 6, 6);
            textBox2.MaxLength = 16;
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(398, 39);
            textBox2.TabIndex = 32;
            textBox2.TextChanged += textBox2_TextChanged;
            // 
            // textBox1
            // 
            textBox1.Location = new Point(243, 186);
            textBox1.Margin = new Padding(6, 6, 6, 6);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(398, 39);
            textBox1.TabIndex = 31;
            textBox1.TextChanged += textBox1_TextChanged;
            // 
            // button1
            // 
            button1.Location = new Point(58, 64);
            button1.Margin = new Padding(6, 6, 6, 6);
            button1.Name = "button1";
            button1.Size = new Size(188, 49);
            button1.TabIndex = 30;
            button1.Text = "<< Kembali";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click_1;
            // 
            // textBox6
            // 
            textBox6.Location = new Point(243, 495);
            textBox6.Margin = new Padding(6, 6, 6, 6);
            textBox6.Name = "textBox6";
            textBox6.Size = new Size(398, 39);
            textBox6.TabIndex = 53;
            textBox6.TextChanged += textBox6_TextChanged;
            // 
            // Form2
            // 
            AutoScaleDimensions = new SizeF(13F, 32F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1749, 881);
            ControlBox = false;
            Controls.Add(textBox6);
            Controls.Add(button6);
            Controls.Add(button3);
            Controls.Add(textBox5);
            Controls.Add(textBox3);
            Controls.Add(radioButton2);
            Controls.Add(radioButton1);
            Controls.Add(dateTimePicker1);
            Controls.Add(label7);
            Controls.Add(dataGridView1);
            Controls.Add(button5);
            Controls.Add(button4);
            Controls.Add(label6);
            Controls.Add(label5);
            Controls.Add(label4);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(button2);
            Controls.Add(textBox4);
            Controls.Add(textBox2);
            Controls.Add(textBox1);
            Controls.Add(button1);
            Margin = new Padding(6, 6, 6, 6);
            Name = "Form2";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Form Data Pasien";
            Load += Form2_Load;
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button button6;
        private Button button3;
        private TextBox textBox5;
        private TextBox textBox3;
        private RadioButton radioButton2;
        private RadioButton radioButton1;
        private DateTimePicker dateTimePicker1;
        private Label label7;
        private DataGridView dataGridView1;
        private Button button5;
        private Button button4;
        private Label label6;
        private Label label5;
        private Label label4;
        private Label label3;
        private Label label2;
        private Label label1;
        private Button button2;
        private TextBox textBox4;
        private TextBox textBox2;
        private TextBox textBox1;
        private Button button1;
        private TextBox textBox6;
    }
}