#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main(void) {
	int num, withDraw, deposit;
	int change = 0;

	while (1) {
		printf("[ ���� �ڵ� �����ý��� ]\n");
		printf("1. �Ա�\n");
		printf("2. ���\n");
		printf("3. ��ȸ\n");
		printf("4. ����\n");
		printf("\n");
		printf("[����(1~4)]");
		scanf("%d", &num);

		switch (num) {
		case 1:
			printf("�Աݾ� : ");
			scanf("%d", &deposit);
			change += deposit;
			break;

		case 2:
			printf("��ݾ� : ");
			scanf("%d", &withDraw);
			change -= withDraw;
			break;

		case 3:
			printf("�ܾ� : %d\n", change);
			break;

		case 4:
			printf("==���α׷� ����==");
			return 0;
			break;

		default :
			printf("�߸��� �����Դϴ�. �ùٸ� ���ڷ� �������ּ���.\n");
			break;
		}

	}
}