import XXH from 'xxhashjs';

export const getId = (data) => parseInt(XXH.h32(data, 0xABCD).toString(16), 16);