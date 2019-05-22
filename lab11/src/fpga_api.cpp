#include "fpga_api.h"
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <cstring>

#define min(x, y) (((x) < (y)) ? (x) : (y))

FPGA::FPGA(off_t data_addr, off_t output_addr, int m_size, int v_size)
{
  m_size_ = m_size;
  v_size_ = v_size;
  data_size_ = (m_size_ + 1) * v_size_ * sizeof(float); // fpga bram data size

  fd_ = open("/dev/mem", O_RDWR);
  data_ = static_cast<float *>(mmap(NULL, data_size_, PROT_READ | PROT_WRITE, MAP_SHARED, fd_, data_addr));
  output_ = static_cast<unsigned int *>(mmap(NULL, sizeof(unsigned int), PROT_READ | PROT_WRITE, MAP_SHARED, fd_, output_addr));

  num_block_call_ = 0;
}

FPGA::~FPGA()
{
  munmap(data_, data_size_);
  munmap(output_, sizeof(unsigned int));
  close(fd_);
}

float *FPGA::matrix(void)
{
  return data_ + v_size_;
}

float *FPGA::vector(void)
{
  return data_;
}

void FPGA::reset(void)
{
  num_block_call_ = 0;
}

int FPGA::num_block_call(void)
{
  return num_block_call_;
}

const float *__attribute__((optimize("O0"))) FPGA::blockMV()
{
  num_block_call_ += 1;

  // fpga version
  *output_ = 0x5555;
  while (*output_ == 0x5555)
    ;

  return data_;
}

void FPGA::largeMV(const float *large_mat, const float *input, float *output, int num_input, int num_output)
{
  float *vec = this->vector();
  float *mat = this->matrix();

  // 0) Initialize output vector
  for (int i = 0; i < num_output; ++i)
    output[i] = 0;

  for (int i = 0; i < num_output; i += m_size_)
  {
    for (int j = 0; j < num_input; j += v_size_)
    {
      // 0) Initialize input vector
      int block_row = min(m_size_, num_output - i);
      int block_col = min(v_size_, num_input - j);

      // 1) Assign a vector
      // IMPLEMENT THIS

      // 2) Assign a matrix
      // IMPLEMENT THIS

      // 3) Call a function `blockMV() to execute MV multiplication
      const float *ret = this->blockMV();

      // 4) Accumulate intermediate results
      for (int row = 0; row < block_row; ++row)
        output[i + row] += ret[row];
    }
  }
}

void FPGA::convLowering(const std::vector<std::vector<std::vector<std::vector<float>>>> &cnn_weights,
                        std::vector<std::vector<float>> &new_weights,
                        const std::vector<std::vector<std::vector<float>>> &inputs,
                        std::vector<std::vector<float>> &new_inputs)
{
	/*
	 * Arguments:
	 *
	 * conv_weights: [conv_channel, input_channel, conv_height, conv_width]
	 * new_weights: [?, ?]
	 * inputs: [input_channel, input_height, input_width]
	 * new_inputs: [?, ?]
	 *
	 */

	int conv_channel = cnn_weights.size();
	int input_channel = cnn_weights[0].size();
	int conv_height = cnn_weights[0][0].size();
	int conv_width = cnn_weights[0][0][0].size();
	//int input_channel = inputs.size();
	int input_height = inputs[0].size();
	int input_width = inputs[0][0].size();

	// IMPLEMENT THIS
	// For example,
	// new_weights[0][0] = cnn_weights[0][0][0][0];
	// new_inputs[0][0] = inputs[0][0][0];
  
	/* Code for new_weights */
	for(int i = 0; i < conv_channel; i++) {
		for(int j = 0; j < input_channel; j++) {
			for(int k = 0; k < conv_height; k++) {
				for(int l = 0; l < conv_width; l++) {
					new_weights[i][j * conv_height * conv_width + k * conv_width + l] = cnn_weights[i][j][k][l];
				}
			}
		}
	}
	
	/* Code for new_inputs */
	int filter_row = input_height - conv_height + 1;
	int filter_col = input_width - conv_width + 1;
	for(int i = 0; i < input_channel; i++) {
		for(int j = conv_height - 1; j >= 0; j--) {
			for(int k = conv_width - 1; k >= 0; k--) {
				for(int m = 0; m < filter_row; m++) {
					for(int n = 0; n < filter_col; n++) {
						new_inputs[i * conv_height * conv_width + j * conv_width + k][m * filter_col + n] = inputs[i][j + m][k + n];
					}
				}
			}
		}
	}
}
