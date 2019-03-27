import { Injectable } from '@nestjs/common';
import { EntityManager } from 'typeorm';
import { User } from './user.entity';

@Injectable()
export class UserService {
  constructor(private readonly manager: EntityManager) {}

  async findOneByUsername(username: string) {
    return await this.manager.findOne<User>(User, {
      where: {
        username,
        deleted: false,
      },
    });
  }

  async findOneByToken(token: string) {
    return await this.manager.findOne<User>(User, {
      where: {
        token,
        deleted: false,
      },
    });
  }
}
