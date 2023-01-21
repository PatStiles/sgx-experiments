**1.) Create Benchmarking Script in Go**

Opensource Implementations:

- EncryptOAEP: [https://pkg.go.dev/crypto/rsa#EncryptOAEP](https://pkg.go.dev/crypto/rsa#EncryptOAEP)

    Results:

    Non-SGX:

    SGX:

- Go RSA Benchmark: [https://github.com/keymastervn/rsa_benchmarking](https://github.com/keymastervn/rsa_benchmarking)

    Results:

    Non-SGX:

    SGX:

- Go RSA: [https://go.dev/src/crypto/rsa/rsa_test.go](https://go.dev/src/crypto/rsa/rsa_test.go)

    Results:

    Non-SGX:

    SGX:

- Go AES: [https://go.dev/src/crypto/aes/aes_test.go](https://go.dev/src/crypto/aes/aes_test.go)

    Results:

    Non-SGX:

    SGX:


Benchmark:

- Results:

    Non-SGX:

    SGX:


**2.) Compare against Non-Go implementation** [https://github.com/ibr-ds/SGXoMeter](https://github.com/ibr-ds/SGXoMeter)

- Results:

    Non-SGX:

    SGX:


**3.) Benchmark Improvements**

Profile benchmark code with perf to confirm I/O behavior

Add warmup phase each benchmark task caches

Run each task in isolated thread

Preprocess ciphertext in memory

Use Go compilation flags to allow for platform specific optimizations

**4.) Performance Improvement Ideas**

Wrap go code in Openssl: [https://pkg.go.dev/github.com/spacemonkeygo/openssl](https://pkg.go.dev/github.com/spacemonkeygo/openssl)

Import c/assembly implementation of rsa into go via cgo or c-shared libraries.