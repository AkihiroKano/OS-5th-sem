#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

// Рекурсивное вычисление чисел Фибоначчи (медленная реализация)
long long fib(int n) {
    if (n <= 1) return n;
    return fib(n-1) + fib(n-2);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <iterations> <param>\n", argv[0]);
        return 1;
    }

    int iterations = atoi(argv[1]);
    int param = atoi(argv[2]);
    double result = 0.0;

    // Динамический массив для усложнения работы с памятью
    double* array = (double*)malloc(iterations * sizeof(double));

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        // 1. Вычисления с плавающей точкой и тригонометрией
        array[i] = sin(param * i * M_PI / 180.0);

        // 2. Вложенные циклы
        for (int j = 0; j < 100; j++) {
            result += pow(array[i], 2.0) * cos(result);
        }

        // 3. Периодический вызов медленной функции
        if (i % 1000 == 0) {
            result += fib(30 + (i % 10)); // Фибоначчи для чисел 30-39
        }
    }

    free(array);

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Result: %.2f\n", result);
    fprintf(stderr, "Execution time: %.2f seconds\n", time_spent);
    return 0;
}
