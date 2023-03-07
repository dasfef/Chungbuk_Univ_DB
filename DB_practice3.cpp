#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

struct students {
	int sub1;
	int sub2;
	int sub3;
};

int main(void) {
	int choice, sub1, sub2, sub3, i, j;
	struct students students[3];
	while (1) {
		printf("\t[[ 성적 처리 시스템 ]]\n");
		printf("1. 점수 입력\n");
		printf("2. 성적 처리\n");
		printf("3. 성적 조회\n");
		printf("4. 종료\n");
		printf("메뉴 선택 >>");
		scanf("%d", &choice);

		switch (choice) {
		case 1:
			for (i = 0; i < 3; i++) {
				printf("- %d번 학생\n", i + 1);
				for (j = 0; j < 3; j++) {
					printf("과목%d 점수 :", j + 1);
					scanf("%d", &students[i].sub[i]);
				}
			}
		}
		
	}
}
