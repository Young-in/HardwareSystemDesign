/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <stdio.h>
#include <vector>

#define CON_CH 4
#define CON_H 3
#define CON_W 2
#define IN_CH 7
#define IN_H 6
#define IN_W 5

void convLowering(const std::vector<std::vector<std::vector<std::vector<float>>>> &cnn_weights,
                        std::vector<std::vector<float>> &new_weights,
                        const std::vector<std::vector<std::vector<float>>> &inputs,
                        std::vector<std::vector<float>> &new_inputs);

using namespace std;

int main()
{
    printf("Started\n");
    
    vector<vector<vector<vector<float>>>> weight;
    vector<vector<vector<float>>> input;
    vector<vector<float>> new_weight;
    vector<vector<float>> new_input;
    
    for(int i = 0; i < IN_CH; i++) {
        vector<vector<float>> new_channel;
        for(int j = 0; j < IN_H; j++) {
            vector<float> new_row;
            for(int k = 0; k < IN_W; k++) {
                new_row.push_back((float) (j*IN_W + k));
            }
            new_channel.push_back(new_row);
        }
        input.push_back(new_channel);
    }
    
    for(int i = 0; i < IN_CH; i++) {
        printf("INPUT CHANNEL: %d\n", i);
        for(int j = 0; j < IN_H; j++) {
            for(int k = 0; k < IN_W; k++) {
                printf("%0.0f ", input[i][j][k]);
            }
            printf("\n");
        }
        printf("========================================================\n");
    }
    
    for(int i = 0; i < CON_CH; i++) {
        vector<vector<vector<float>>> new_channel;
        for(int j = 0; j < IN_CH; j++) {
            vector<vector<float>> new_input_channel;
            for(int k = 0; k < CON_H; k++) {
                vector<float> new_row;
                for(int l = 0; l <  CON_W; l++) {
                    new_row.push_back((float) (100*i + 30 + k*CON_W + l));
                }
                new_input_channel.push_back(new_row);
            }
            new_channel.push_back(new_input_channel);
        }
        weight.push_back(new_channel);
    }
    for(int i = 0; i < CON_CH; i++) {
        for(int j = 0; j < IN_CH; j++) {
            printf("WEIGHT CHANNEL: (%d, %d)\n", i, j);
            for(int k = 0; k < CON_H; k++) {
                for(int l = 0; l < CON_W; l++) {
                    printf("%0.0f ", weight[i][j][k][l]);
                }
                printf("\n");
            }
            printf("========================================================\n");
        }
        
    }
    
    convLowering(weight, new_weight, input, new_input);
    
    printf("NEW WEIGHT\n");
    for(int i = 0; i < new_weight.size(); i++) {
        for(int j = 0; j < new_weight[0].size(); j++) {
            printf("%0.0f ", new_weight[i][j]);
        }
        printf("\n");
    }
    
    printf("NEW INPUT\n");
    for(int i = 0; i < new_input.size(); i++) {
        for(int j = 0; j < new_input[0].size(); j++) {
            printf("%0.0f ", new_input[i][j]);
        }
        printf("\n");
    }

    return 0;
}

void convLowering(const std::vector<std::vector<std::vector<std::vector<float>>>> &cnn_weights,
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
		std::vector<float> new_row;
		for(int j = 0; j < input_channel; j++) {
			for(int k = 0; k < conv_height; k++) {
				for(int l = 0; l < conv_width; l++) {
					new_row.push_back(cnn_weights[i][j][k][l]);
				}
			}
		}
		new_weights.push_back(new_row);
	}
	
	/* Code for new_inputs */
	int filter_col = input_height - conv_height + 1;
	int filter_row = input_width - conv_width + 1;
	
	for(int i = 0; i < input_channel; i++) {
		for(int j = conv_height - 1; j >= 0; j--) {
			for(int k = conv_width - 1; k >= 0; k--) {
				std::vector<float> new_row;
				for(int m = 0; m < filter_row; m++) {
					for(int n = 0; n < filter_col; n++) {
						new_row.push_back(inputs[i][j + m][k + n]);
					}
				}
				new_inputs.push_back(new_row);
			}
		}
	}
}
