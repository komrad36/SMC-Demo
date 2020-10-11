#include <chrono>
#include <iostream>

using namespace std::chrono;

extern "C" bool TestSmc();

int main()
{
	std::cout << std::endl << "SMC test " << (TestSmc() ? "successful." : "FAILED.") << std::endl;

	constexpr size_t kRuns = 20000;
	auto start = high_resolution_clock::now();
	for (size_t i = 0; i < kRuns; ++i)
		TestSmc();
	auto end = high_resolution_clock::now();
	const double ns = (double)(duration_cast<nanoseconds>(end - start).count()) / kRuns;

	std::cout << "SMC test took " << ns << " ns." << std::endl;
}
