#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main(void)
{
	int choice;
	int i, num, num2;
	int cnt = 0;
	
	while (1) {
		printf("== �޴� ���� ==\n");
		printf("1. ������ϱ�\n");
		printf("2. �Ҽ����� Ȯ���ϱ�\n");
		printf("3. ����\n");
		printf("�޴� ���� >>");
		scanf("%d", &choice);

		switch (choice) {
		case 1:
			printf("������ ���� �Է� >>");
			scanf("%d", &num);
			for (i = 1; i <= num; i++) {
				if (num % i == 0) {
					printf("%d\t", i);
				}
			}
			printf("\n");
			break;

		case 2:
			cnt = 0;
			printf("������ ���� �Է� >>");
			scanf("%d", &num2);
			for (i = 1; i <= num2; i++) {
				if (num2 % i == 0) {
					++cnt;
				}
			}
			if (cnt == 2) {
				printf("%d��(��) �Ҽ��Դϴ�\n", num2);
			}
			else 
				printf("%d��(��) �Ҽ��� �ƴմϴ�\n", num2);
			break;

		case 3:
			printf("==���α׷� ����==");
			return 0;
			break;

		default:
			printf("�������� �ʴ� �޴��Դϴ�. �ٽ� �����ϼ���\n");
			break;
		}
	}
}