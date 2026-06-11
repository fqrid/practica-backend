import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity('estudiante')
export class Estudiante {
  @ApiProperty({ example: 1 })
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ example: 'Juan Perez' })
  @Column()
  nombre: string;

  @ApiProperty({ example: '2026001' })
  @Column({ unique: true })
  codigo: string;
}
