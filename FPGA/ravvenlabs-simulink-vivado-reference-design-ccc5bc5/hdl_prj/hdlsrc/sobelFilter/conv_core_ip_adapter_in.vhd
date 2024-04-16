-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\sobelFilter\conv_core_ip_adapter_in.vhd
-- Created: 2024-04-16 16:13:22
-- 
-- Generated by MATLAB 24.1, HDL Coder 24.1, and Simulink 24.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: conv_core_ip_adapter_in
-- Source Path: conv_core_ip/conv_core_ip_axi4_stream_video_slave/conv_core_ip_adapter_in
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY conv_core_ip_adapter_in IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        stream_in_fifo_user_data          :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        stream_in_user_valid              :   IN    std_logic;  -- ufix1
        stream_in_user_sof                :   IN    std_logic;  -- ufix1
        stream_in_user_eol                :   IN    std_logic;  -- ufix1
        image_width                       :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
        image_height                      :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
        hporch                            :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
        vporch                            :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
        adapter_in_enable                 :   IN    std_logic;  -- ufix1
        user_pixel                        :   OUT   std_logic_vector(63 DOWNTO 0);  -- ufix64
        user_ctrl_hStart                  :   OUT   std_logic;  -- ufix1
        user_ctrl_hEnd                    :   OUT   std_logic;  -- ufix1
        user_ctrl_vStart                  :   OUT   std_logic;  -- ufix1
        user_ctrl_vEnd                    :   OUT   std_logic;  -- ufix1
        adapter_in_valid_out              :   OUT   std_logic;  -- ufix1
        adapter_in_ready_out              :   OUT   std_logic  -- ufix1
        );
END conv_core_ip_adapter_in;


ARCHITECTURE rtl OF conv_core_ip_adapter_in IS

  -- Component Declarations
  COMPONENT conv_core_ip_adapter_in_module
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          data_in                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          tvalid                          :   IN    std_logic;  -- ufix1
          sof                             :   IN    std_logic;  -- ufix1
          eol                             :   IN    std_logic;  -- ufix1
          image_length                    :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          image_height                    :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          hporch                          :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          vporch                          :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          data_out                        :   OUT   std_logic_vector(63 DOWNTO 0);  -- ufix64
          hstart                          :   OUT   std_logic;  -- ufix1
          hend                            :   OUT   std_logic;  -- ufix1
          vstart                          :   OUT   std_logic;  -- ufix1
          vend                            :   OUT   std_logic;  -- ufix1
          valid                           :   OUT   std_logic;  -- ufix1
          ready_out                       :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : conv_core_ip_adapter_in_module
    USE ENTITY work.conv_core_ip_adapter_in_module(rtl);

  -- Signals
  SIGNAL user_pixel_tmp                   : std_logic_vector(63 DOWNTO 0);  -- ufix64

BEGIN
  u_conv_core_ip_conv_core_ip_axi4_stream_video_slave_conv_core_ip_adapter_in_conv_core_ip_adapter_in_module : conv_core_ip_adapter_in_module
    PORT MAP( clk => clk,
              reset => reset,
              enb => adapter_in_enable,
              data_in => stream_in_fifo_user_data,  -- ufix64
              tvalid => stream_in_user_valid,  -- ufix1
              sof => stream_in_user_sof,  -- ufix1
              eol => stream_in_user_eol,  -- ufix1
              image_length => image_width,  -- ufix13
              image_height => image_height,  -- ufix13
              hporch => hporch,  -- ufix13
              vporch => vporch,  -- ufix13
              data_out => user_pixel_tmp,  -- ufix64
              hstart => user_ctrl_hStart,  -- ufix1
              hend => user_ctrl_hEnd,  -- ufix1
              vstart => user_ctrl_vStart,  -- ufix1
              vend => user_ctrl_vEnd,  -- ufix1
              valid => adapter_in_valid_out,  -- ufix1
              ready_out => adapter_in_ready_out  -- ufix1
              );

  user_pixel <= user_pixel_tmp;

END rtl;

