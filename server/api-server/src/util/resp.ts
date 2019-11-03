import { SERVER_ERROR, SUCCESS, RESP_CODE } from './resp.code';

export interface Resp<T> {
  code: RESP_CODE;
  data: T;
  msg: string;
}

export const success = <T>(data: T, code: RESP_CODE = SUCCESS): Resp<T> => {
  return {
    code,
    data,
    msg: 'success',
  };
};

export const error = <T>(
  data: T,
  msg: string = 'error',
  code: RESP_CODE = SERVER_ERROR,
): Resp<T> => {
  return {
    code,
    data,
    msg,
  };
};
