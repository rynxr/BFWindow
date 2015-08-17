#include <stdio.h>
#include <stdlib.h>

void print_user_inputs(char *text);
void set_motor_speed(int speed);
void set_moter_voltage(int voltage);
void print_motor_detail_status(void);
void print_motor_speed(void);

/* bf_attack.c */
int main(int argc, char ** argv)
{
	int usr_priority;
	int motor_params[2];
	char input_text[64];

	//motor speed
	scanf("%d", &motor_params[0]);

	//motor voltage
	scanf("%d", &motor_params[1]);

	//display info level
	scanf("%d", &usr_priority);

	//!!!buffer overflow here!!!
	scanf("%s", input_text);

	//display user inputs
	print_user_inputs(input_text);

	//motor speed
	set_motor_speed(motor_params[0]);

	//motor voltage
	set_moter_voltage(motor_params[1]);

	//display motor status
	if (usr_priority == 0) { //root debug
		print_motor_detail_status();
	} else { //normal status print
		print_motor_speed();
	}

	return 0;
}

/* dummy functions */
void set_motor_speed(int speed)
{
	printf("ERROR: program is attacked without detection!\n");
}

void set_moter_voltage(int voltage)
{
	printf("INFO: program is attacked but with protection!\n");
}

void print_motor_detail_status()
{
	printf("ERROR: program is attacked without detection!\n");
}

void print_motor_speed()
{
	printf("INFO: program is attacked but with protection!\n");
}

void print_user_inputs(char *text)
{
	printf("INFO: user input=%s\n", text);
}
