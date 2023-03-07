#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main(void) {
	int num, withDraw, deposit;
	int change = 0;

	while (1) {
		printf("[ 은행 자동 업무시스템 ]\n");
		printf("1. 입금\n");
		printf("2. 출금\n");
		printf("3. 조회\n");
		printf("4. 종료\n");
		printf("\n");
		printf("[선택(1~4)]");
		scanf("%d", &num);

		switch (num) {
		case 1:
			printf("입금액 : ");
			scanf("%d", &deposit);
			change += deposit;
			break;

		case 2:
			printf("출금액 : ");
			scanf("%d", &withDraw);
			change -= withDraw;
			break;

		case 3:
			printf("잔액 : %d\n", change);
			break;

		case 4:
			printf("==프로그램 종료==");
			return 0;
			break;

		default :
			printf("잘못된 선택입니다. 올바른 숫자로 선택해주세요.\n");
			break;
		}

	}
}