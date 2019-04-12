export const SUCCESS = 200;

/**
 * ERROR CODE
 */
export const BAD_REQUEST = 400;
export const UNAUTHORIZED = 401;
export const SERVER_ERROR = 500;

export type RESP_CODE =
  | typeof SUCCESS
  | typeof BAD_REQUEST
  | typeof UNAUTHORIZED
  | typeof SERVER_ERROR;
