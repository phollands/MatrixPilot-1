// pyparam generated file - DO NOT EDIT


#include "parameter_table.h"
#include "data_services.h"


const mavlink_parameter_block    mavlink_parameter_blocks[] = {
    { STORAGE_HANDLE_CONTROL_GAINS , 0 , 8 , STORAGE_FLAG_LOAD_AT_STARTUP | STORAGE_FLAG_LOAD_AT_REBOOT | STORAGE_FLAG_STORE_CALIB , NULL },
    { STORAGE_HANDLE_MAG_CALIB , 8 , 10 , STORAGE_FLAG_LOAD_AT_STARTUP | STORAGE_FLAG_LOAD_AT_REBOOT | STORAGE_FLAG_STORE_CALIB , NULL },
    { STORAGE_HANDLE_RADIO_TRIM , 18 , 15 , STORAGE_FLAG_LOAD_AT_STARTUP | STORAGE_FLAG_LOAD_AT_REBOOT | STORAGE_FLAG_STORE_CALIB , &udb_skip_radio_trim },
    { STORAGE_HANDLE_IMU_CALIB , 33 , 7 , STORAGE_FLAG_LOAD_AT_REBOOT | STORAGE_FLAG_STORE_CALIB , &udb_skip_imu_calibration },
    };


const unsigned int mavlink_parameter_block_count = sizeof(mavlink_parameter_blocks) / sizeof(mavlink_parameter_block);


