import * as jwt from 'jsonwebtoken';
import { Injectable } from '@nestjs/common';
import { UserService } from 'src/user/user.service';
import { JwtPayload } from './interfaces/jwt-payload.interface';
import { secretKey } from 'src/constant/constantKey';

@Injectable()
export class AuthService {
  constructor(private readonly userService: UserService) {}

  async createToken(username: string) {
    const user: JwtPayload = { username };
    return await jwt.sign(user, secretKey, { expiresIn: 3600 });
  }

  async validateUser(username: string) {
    return await this.userService.findOneByUsername(username);
  }
}
