#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main(void)
{
	int choice;
	int i, num, num2;
	int cnt = 0;
	
	while (1) {
		printf("== 메뉴 선택 ==\n");
		printf("1. 약수구하기\n");
		printf("2. 소수여부 확인하기\n");
		printf("3. 종료\n");
		printf("메뉴 선택 >>");
		scanf("%d", &choice);

		switch (choice) {
		case 1:
			printf("임의의 정수 입력 >>");
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
			printf("임의의 정수 입력 >>");
			scanf("%d", &num2);
			for (i = 1; i <= num2; i++) {
				if (num2 % i == 0) {
					++cnt;
				}
			}
			if (cnt == 2) {
				printf("%d은(는) 소수입니다\n", num2);
			}
			else 
				printf("%d은(는) 소수가 아닙니다\n", num2);
			break;

		case 3:
			printf("==프로그램 종료==");
			return 0;
			break;

		default:
			printf("존재하지 않는 메뉴입니다. 다시 선택하세요\n");
			break;
		}
	}
}