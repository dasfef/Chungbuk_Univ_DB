#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

struct students {
	int sub1;
	int sub2;
	int sub3;
};

struct result {
	int sum;
	int avg;
	int rank;
};

int main(void) {
	int choice, sub1, sub2, sub3, i, j;
	int cnt = 0;
	struct students s[3];
	struct result score[3];

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
				printf("과목1 점수 : ");
				scanf("%d", &s[i].sub1);
				printf("과목2 점수 : ");
				scanf("%d", &s[i].sub2);
				printf("과목3 점수 : ");
				scanf("%d", &s[i].sub3);

			}
			break;

		case 2:
			for (i = 0; i < 3; i++) {
				score[i].sum = s[i].sub1 + s[i].sub2 + s[i].sub3;
				score[i].avg = score[i].sum / 3;
				
			}
			for (i = 0; i < 3; i++) {
				cnt = 0;
				for (j = 0; j < 3; j++) {
					if (score[i].avg < score[j].avg)
						cnt++;
				}
				score[i].rank = cnt + 1;
			}
			break;
		
		case 3:
			printf("===================================================================\n");
			printf("\t번호\t과목1\t과목2\t과목3\t총합\t평균\t순위\n");
			printf("-------------------------------------------------------------------\n");
			for (i = 0; i < 3; i++) {
				printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", i+1, s[i].sub1, s[i].sub2, s[i].sub3, score[i].sum, score[i].avg, score[i].rank);
			}
			printf("-------------------------------------------------------------------\n");
			break;

		case 4:
			printf("프로그램 종료");
			return 0;
			break;
			
		default :
			printf("올바른 번호를 선택해주세요\n");
			break;
		}
		

	}
}
