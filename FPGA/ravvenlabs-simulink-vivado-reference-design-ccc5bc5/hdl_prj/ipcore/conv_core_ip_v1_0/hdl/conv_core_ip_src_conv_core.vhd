-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\sobelFilter\conv_core_ip_src_conv_core.vhd
-- Created: 2024-04-16 16:13:01
-- 
-- Generated by MATLAB 24.1, HDL Coder 24.1, and Simulink 24.1
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 2.77039e-06
-- Target subsystem base rate: 2.77039e-06
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        2.77039e-06
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Video_out                     ce_out        2.77039e-06
-- valid_out_hStart              ce_out        2.77039e-06
-- valid_out_hEnd                ce_out        2.77039e-06
-- valid_out_vStart              ce_out        2.77039e-06
-- valid_out_vEnd                ce_out        2.77039e-06
-- valid_out_valid               ce_out        2.77039e-06
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: conv_core_ip_src_conv_core
-- Source Path: sobelFilter/conv_core
-- Hierarchy Level: 0
-- Model version: 6.0
-- 
-- Simulink model description for sobelFilter:
-- 
-- Sobel Edge Detection Using the MATLAB(R) Function Block
-- This example shows how to use HDL Coder(TM) to check, 
-- generate, and verify HDL code for a Sobel Edge Detection 
-- block built using the MATLAB Function block.
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.conv_core_ip_src_conv_core_pkg.ALL;

ENTITY conv_core_ip_src_conv_core IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        Video_in                          :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        ctrl_hStart                       :   IN    std_logic;
        ctrl_hEnd                         :   IN    std_logic;
        ctrl_vStart                       :   IN    std_logic;
        ctrl_vEnd                         :   IN    std_logic;
        ctrl_valid                        :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        Video_out                         :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        valid_out_hStart                  :   OUT   std_logic;
        valid_out_hEnd                    :   OUT   std_logic;
        valid_out_vStart                  :   OUT   std_logic;
        valid_out_vEnd                    :   OUT   std_logic;
        valid_out_valid                   :   OUT   std_logic
        );
END conv_core_ip_src_conv_core;


ARCHITECTURE rtl OF conv_core_ip_src_conv_core IS

  -- Component Declarations
  COMPONENT conv_core_ip_src_Subsystem1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In2                             :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          coeffs_0                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_1                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_2                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_3                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_4                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_5                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_6                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_7                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          coeffs_8                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
          Enable                          :   IN    std_logic;
          Video_out                       :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : conv_core_ip_src_Subsystem1
    USE ENTITY work.conv_core_ip_src_Subsystem1(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL c8_Constant_out1                 : vector_of_signed16(0 TO 8);  -- sfix16_En12 [9]
  SIGNAL Constant_out1                    : matrix_of_signed16(0 TO 2, 0 TO 2);  -- sfix16_En12 [3x3]
  SIGNAL Transpose_out1                   : matrix_of_signed16(0 TO 2, 0 TO 2);  -- sfix16_En12 [3x3]
  SIGNAL Reshape_out1                     : vector_of_signed16(0 TO 8);  -- sfix16_En12 [9]
  SIGNAL valid                            : std_logic;
  SIGNAL Subsystem1_out1                  : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL alpha_reg                        : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay1_out1_hStart               : std_logic;
  SIGNAL alpha_reg_1                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay1_out1_hEnd                 : std_logic;
  SIGNAL alpha_reg_2                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay1_out1_vStart               : std_logic;
  SIGNAL alpha_reg_3                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay1_out1_vEnd                 : std_logic;
  SIGNAL alpha_reg_4                      : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL Delay1_out1_valid                : std_logic;

BEGIN
  u_Subsystem1 : conv_core_ip_src_Subsystem1
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              In2 => Video_in,  -- ufix64
              coeffs_0 => std_logic_vector(Reshape_out1(0)),  -- sfix16_En12
              coeffs_1 => std_logic_vector(Reshape_out1(1)),  -- sfix16_En12
              coeffs_2 => std_logic_vector(Reshape_out1(2)),  -- sfix16_En12
              coeffs_3 => std_logic_vector(Reshape_out1(3)),  -- sfix16_En12
              coeffs_4 => std_logic_vector(Reshape_out1(4)),  -- sfix16_En12
              coeffs_5 => std_logic_vector(Reshape_out1(5)),  -- sfix16_En12
              coeffs_6 => std_logic_vector(Reshape_out1(6)),  -- sfix16_En12
              coeffs_7 => std_logic_vector(Reshape_out1(7)),  -- sfix16_En12
              coeffs_8 => std_logic_vector(Reshape_out1(8)),  -- sfix16_En12
              Enable => valid,
              Video_out => Subsystem1_out1  -- uint32
              );

  c8_Constant_out1(0) <= to_signed(16#1000#, 16);
  c8_Constant_out1(1) <= to_signed(16#2000#, 16);
  c8_Constant_out1(2) <= to_signed(16#1000#, 16);
  c8_Constant_out1(3) <= to_signed(16#0000#, 16);
  c8_Constant_out1(4) <= to_signed(16#0000#, 16);
  c8_Constant_out1(5) <= to_signed(16#0000#, 16);
  c8_Constant_out1(6) <= to_signed(-16#1000#, 16);
  c8_Constant_out1(7) <= to_signed(-16#2000#, 16);
  c8_Constant_out1(8) <= to_signed(-16#1000#, 16);

  Constant_out1_gen1: FOR d1 IN 0 TO 2 GENERATE
    Constant_out1_gen: FOR d0 IN 0 TO 2 GENERATE
      Constant_out1(d0, d1) <= c8_Constant_out1(d0 + (d1 * 3));
    END GENERATE;
  END GENERATE;


  Transpose_out1_gen: FOR t_1 IN 0 TO 2 GENERATE
    Transpose_out1_gen_1: FOR t_0 IN 0 TO 2 GENERATE
      Transpose_out1(t_0, t_1) <= Constant_out1(t_1, t_0);
    END GENERATE Transpose_out1_gen_1;
  END GENERATE Transpose_out1_gen;


  Reshape_out1_gen1: FOR d1 IN 0 TO 2 GENERATE
    Reshape_out1_gen: FOR d0 IN 0 TO 2 GENERATE
      Reshape_out1(d0 + (d1 * 3)) <= Transpose_out1(d0, d1);
    END GENERATE;
  END GENERATE;

  valid <= ctrl_valid;

  enb <= clk_enable;

  c_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        alpha_reg <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        alpha_reg(0) <= ctrl_hStart;
        alpha_reg(1) <= alpha_reg(0);
      END IF;
    END IF;
  END PROCESS c_process;

  Delay1_out1_hStart <= alpha_reg(1);

  c_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        alpha_reg_1 <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        alpha_reg_1(0) <= ctrl_hEnd;
        alpha_reg_1(1) <= alpha_reg_1(0);
      END IF;
    END IF;
  END PROCESS c_1_process;

  Delay1_out1_hEnd <= alpha_reg_1(1);

  c_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        alpha_reg_2 <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        alpha_reg_2(0) <= ctrl_vStart;
        alpha_reg_2(1) <= alpha_reg_2(0);
      END IF;
    END IF;
  END PROCESS c_2_process;

  Delay1_out1_vStart <= alpha_reg_2(1);

  c_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        alpha_reg_3 <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        alpha_reg_3(0) <= ctrl_vEnd;
        alpha_reg_3(1) <= alpha_reg_3(0);
      END IF;
    END IF;
  END PROCESS c_3_process;

  Delay1_out1_vEnd <= alpha_reg_3(1);

  c_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        alpha_reg_4 <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        alpha_reg_4(0) <= ctrl_valid;
        alpha_reg_4(1) <= alpha_reg_4(0);
      END IF;
    END IF;
  END PROCESS c_4_process;

  Delay1_out1_valid <= alpha_reg_4(1);

  ce_out <= clk_enable;

  Video_out <= Subsystem1_out1;

  valid_out_hStart <= Delay1_out1_hStart;

  valid_out_hEnd <= Delay1_out1_hEnd;

  valid_out_vStart <= Delay1_out1_vStart;

  valid_out_vEnd <= Delay1_out1_vEnd;

  valid_out_valid <= Delay1_out1_valid;

END rtl;

