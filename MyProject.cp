#line 1 "C:/Users/LENOVO/Desktop/MyProject.c"
#line 19 "C:/Users/LENOVO/Desktop/MyProject.c"
sbit CS_bit at RC0_bit;
sbit CS_Direction_bit at TRISC0_bit;

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


unsigned short temp;
char out[16];
int readings[3] = {0, 0, 0};

void ADXL345_Write(unsigned short address, unsigned short data1) {
 unsigned short internal = 0;
 internal = address |  0x00 ;

 CS_bit = 0;
 SPI1_Write(internal);
 SPI1_Write(data1);
 CS_bit = 1;
}

unsigned short ADXL345_Read(unsigned short address) {
 unsigned short internal = 0;
 internal = address |  0x80 ;

 CS_bit = 0;
 SPI1_Write(internal);
 internal = SPI1_Read(0);
 CS_bit = 1;

 return internal;
}

void main() {
 TRISB = 0x00;

 CS_bit = 1;
 CS_Direction_bit = 0;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_HIGH, _SPI_LOW_2_HIGH);

 ADXL345_Write( 0x2D , 0x00);

 ADXL345_Write( 0x31 , 0x0B);

 ADXL345_Write( 0x2C ,  0x0F );

 ADXL345_Write( 0x2D , 0x08);

 while (1) {




 readings[0] = ADXL345_Read( 0x32 ) << 8;


 readings[0] = readings[0] | ADXL345_Read( 0x33 );


 readings[1] = ADXL345_Read( 0x34 ) << 8;


 readings[1] = readings[1] | ADXL345_Read( 0x35 );


 readings[2] = ADXL345_Read( 0x36 ) << 8;


 readings[2] = readings[2] | ADXL345_Read( 0x37 );



 IntToStr(readings[0], out);
 LCD_Out(1,1,out);

 Delay_ms(100);


 IntToStr(readings[1], out);
 LCD_Out(2,1,out);

 Delay_ms(100);


 IntToStr(readings[2], out);
 LCD_Out(2,7,out);

 }
}
