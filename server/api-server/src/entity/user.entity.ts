import { Entity, Column } from 'typeorm';
import { Base } from './base.entity';

@Entity('Ngg_User')
export class User extends Base {
  @Column({
    unique: true,
    nullable: false,
  })
  username: string;

  @Column({
    nullable: false,
  })
  password: string;

  @Column({
    type: 'bigint',
    nullable: false,
    default: 0,
  })
  signNum: number;
}
