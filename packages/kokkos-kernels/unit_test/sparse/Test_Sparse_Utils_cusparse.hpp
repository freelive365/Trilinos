#include<gtest/gtest.h>
#include<Kokkos_Core.hpp>

#include "KokkosKernels_SparseUtils_cusparse.hpp"

void test_cusparse_safe_call() {
  bool caught_exception = false;

  cusparseStatus_t myStatus = CUSPARSE_STATUS_SUCCESS;
  KOKKOS_CUSPARSE_SAFE_CALL(myStatus);

  try {
    myStatus = CUSPARSE_STATUS_INVALID_VALUE;
    KOKKOS_CUSPARSE_SAFE_CALL(myStatus);
  } catch (std::runtime_error& e) {
    caught_exception = true;
  }

  EXPECT_TRUE(caught_exception == true);

}

TEST_F( TestCategory, sparse_cusparse_safe_call ) { \
	test_cusparse_safe_call (); \
}
