import { Injectable, BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { User } from '../../entity/user.entity';
import { hash } from 'bcrypt';
import { SALT_ROUNDS } from '../../constant/constantKey';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async findByUsername(username: string) {
    return await this.userRepository.findOne({ username });
  }

  /**
   * Create User Account
   * @param username string
   * @param password string
   * @returns user
   */
  async create(username: string, password: string) {
    const hasUser = await this.findByUsername(username);
    if (hasUser) {
      throw new BadRequestException();
    }
    // Encrypt Password
    const encryptPassword = await hash(password, SALT_ROUNDS);
    let user = await this.userRepository.create({
      username,
      password: encryptPassword,
    });
    user = await this.userRepository.save(user);
    return user;
  }
}
