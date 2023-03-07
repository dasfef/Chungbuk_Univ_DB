#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

enum GENRE {
	만화,
	공상과학,
	소설,
	고전,
	기타
};

struct BOOKS {
	char title[40];
	char writer[40];
	char position[40];
	int category;
};

void addFunction(struct BOOKS *books, enum GENRE *genre, int cnt) {
	int i;
	
	for (i = cnt;;) {
		printf("제목 : ");
		scanf("%s", &books[i].title);
		printf("저자 : ");
		scanf("%s", &books[i].writer);
		printf("위치 : ");
		scanf("%s", &books[i].position);
		printf("장르(1.만화 2.공상과학 3.소설 4.고전 5.기타) : ");
		scanf("%d", &genre[i]);
	}
	cnt++;
	
}

void print_functions(struct BOOKS *books, enum GENRE *genre) {
	int i;
	for (i = 0; i < 3; i++) {
		printf("제목 : %s", books[i].title);
		printf("저자 : %s", books[i].writer);
		printf("위치 : %s", books[i].position);

		switch (genre[i]) {
		case 0:
			printf("만화");
			break;

		case 1:
			printf("공상과학");
			break;

		case 2:
			printf("소설");
			break;

		case 3:
			printf("고전");
			break;

		case 4:
			printf("기타");
		}
	}
}

int main(void) {
	struct BOOKS books[3];
	enum GENRE genre[3];

	int choice;
	int cnt = 0;

	while (1) {
		printf("====================\n");
		printf("1. 추가");
		printf("2. 출력");
		printf("3. 검색");
		printf("4. 종료");
		printf("\n번호 선택 : ");
		scanf("%d", &choice);

		switch (choice) {
		case 1:
			addFunction(books, genre, cnt);
			break;

		case 2:
			print_functions(books, genre);
		}
	}
}
