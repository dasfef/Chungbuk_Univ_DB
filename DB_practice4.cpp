#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>

enum GENRE {
	만화,
	공상과학,
	소설,
	고전,
	기타
};

struct BOOKS {
	char title[20] = {};
	char writer[20] = {};
	char position[20] = {};
	int category;
};

void addFunction(struct BOOKS* books, enum GENRE* genre, int *cnt) {
	int i;

	if (*cnt > 2) {
		printf("※ 더이상 추가할 수 없습니다 ※\n");
		return ;
	}
		
	for (i = *cnt;i < (*cnt)+1;i++) {
		getchar();
		printf("제목 : ");
		scanf("%[^\n]", &books[i].title);
		getchar();
		printf("저자 : ");
		scanf("%[^\n]", &books[i].writer);
		getchar();
		printf("위치 : ");
		scanf("%[^\n]", &books[i].position);
		getchar();
		printf("장르(1.만화 2.공상과학 3.소설 4.고전 5.기타) : ");
		scanf("%d", &genre[i]);
	}
	(*cnt)++;

}

void print_functions(struct BOOKS* books, enum GENRE* genre, int *cnt) {
	
	int i;
	for (i = 0; i < *cnt; i++) {
		printf("___출력결과___");
		printf("\n제목 : %s\n", books[i].title);
		printf("저자 : %s\n", books[i].writer);
		printf("위치 : %s\n", books[i].position);

		switch (genre[i]) {
		case 1:
			printf("[[ 만화 ]]\n");
			break;

		case 2:
			printf("[[ 공상과학 ]]\n");
			break;

		case 3:
			printf("[[ 소설 ]]\n");
			break;

		case 4:
			printf("[[ 고전 ]]\n");
			break;

		case 5:
			printf("[[ 기타 ]]\n");
			break;
		}
	}
}

void search_functions(struct BOOKS* books, enum GENRE* genre, int *cnt) {
	int i, num;
	int index = 0;
	char file[20] = {};
	
	getchar();
	printf("도서 제목 : ");
	scanf("%[^\n]", &file);
	for (i = 0; i < *cnt; i++) {
		if (strcmp(books[i].title, file) == 0) {
			index = 1;
			num = i;
		}
	}

	if (index == 0) {
		printf("※ 찾는 도서가 없습니다 ※\n");
		return;
	}

	else {
		printf("\n___출력결과___");
		printf("\n제목 : %s\n", books[num].title);
		printf("저자 : %s\n", books[num].writer);
		printf("위치 : %s\n", books[num].position);

		switch (genre[num]) {
		case 1:
			printf("[[ 만화 ]]\n");
			break;

		case 2:
			printf("[[ 공상과학 ]]\n");
			break;

		case 3:
			printf("[[ 소설 ]]\n");
			break;

		case 4:
			printf("[[ 고전 ]]\n");
			break;

		case 5:
			printf("[[ 기타 ]]\n");
			break;
		}
	}
		
	
	
}

int main(void) {
	struct BOOKS books[3];
	enum GENRE genre[3];

	int choice;
	int cnt = 0;;
	

	while (1) {
		printf("\n =======START=======\n");
		printf("||    1. 추가\t   ||\n");
		printf("||    2. 출력\t   ||\n");
		printf("||    3. 검색\t   ||\n");
		printf("||    4. 종료\t   ||\n");
		printf(" ===================\n");
		printf("\n번호 선택 : ");
		scanf("%d", &choice);
		printf("\n");

		switch (choice) {
		case 1:
			addFunction(books, genre, &cnt);
			break;

		case 2:
			print_functions(books, genre, &cnt);
			break;

		case 3:
			search_functions(books, genre, &cnt);
			break;

		case 4:
			return 0;
			break;

		default :
			printf("정확한 번호를 골라주세요\n");
			break;
		}
	}
}
