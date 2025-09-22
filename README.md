# WordPress Docker Development Environment

A complete Docker-based development environment for WordPress projects. This template provides a full-stack WordPress setup with MySQL database, phpMyAdmin, and WP-CLI.

## 🚀 Quick Start

1. **Clone this repository**
   ```bash
   git clone <your-repo-url>
   cd wordpress-docker
   ```

2. **Set up environment variables**
   ```bash
   cp env.example .env
   ```
   Edit `.env` file with your preferred settings.

3. **Start the development environment**
   ```bash
   docker-compose up -d
   ```

4. **Access your WordPress site**
   - WordPress: http://localhost:8090
   - phpMyAdmin: http://localhost:8091
   - Database: localhost:3307

## 📁 Project Structure

```
├── docker-compose.yml      # Docker services configuration
├── .env                   # Environment variables (create from env.example)
├── env.example           # Environment variables template
├── database/
│   ├── backups/          # Database backup files
│   └── db-init/          # Database initialization scripts
├── scripts/              # Utility scripts
│   ├── backup.sh         # Database backup script
│   ├── quick-backup.sh   # Quick backup script
│   └── restore.sh        # Database restore script
└── website/
    ├── plugins/          # Custom WordPress plugins
    ├── themes/           # Custom WordPress themes
    ├── uploads/          # WordPress uploads directory
    └── wordpress/        # WordPress core files
```

## 🛠️ Services

### WordPress
- **Container:** `wp_site`
- **Port:** 8090 (configurable via `WORDPRESS_PORT`)
- **Volume:** `./website/wordpress` mounted to `/var/www/html`

### MySQL Database
- **Container:** `wp_db`
- **Port:** 3307 (configurable via `MYSQL_PORT`)
- **Persistent storage:** Docker volume `db_data`

### phpMyAdmin
- **Container:** `wp_phpmyadmin`
- **Port:** 8091 (configurable via `PHPMYADMIN_PORT`)

### WP-CLI
- **Container:** `wp_cli`
- **Purpose:** WordPress command-line management

## ⚙️ Configuration

### Environment Variables

Copy `env.example` to `.env` and customize:

```env
# WordPress Configuration
WORDPRESS_DB_HOST=db
WORDPRESS_DB_USER=wordpress
WORDPRESS_DB_PASSWORD=your_secure_password
WORDPRESS_DB_NAME=wordpress

# MySQL Database Configuration
MYSQL_DATABASE=wordpress
MYSQL_USER=wordpress
MYSQL_PASSWORD=your_secure_password
MYSQL_ROOT_PASSWORD=your_root_password

# Port Configuration
WORDPRESS_PORT=8090
PHPMYADMIN_PORT=8091
MYSQL_PORT=3307
```

### Default Credentials

**Database Access:**
- Host: `localhost:3307`
- Username: `wordpress`
- Password: `wordpress_password` (change in `.env`)
- Database: `wordpress`

**phpMyAdmin:**
- URL: http://localhost:8091
- Username: `wordpress`
- Password: `wordpress_password` (change in `.env`)

## 🔧 Common Commands

### Start the environment
```bash
docker-compose up -d
```

### Stop the environment
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f wordpress
```

### Access WP-CLI
```bash
docker-compose exec wpcli wp --info
```

### Backup database
```bash
docker-compose exec db mysqldump -u wordpress -p wordpress > ./database/backups/backup-$(date +%Y%m%d-%H%M%S).sql
```

### Restore database
```bash
docker-compose exec -T db mysql -u wordpress -p wordpress < ./database/backups/your-backup.sql
```

## 📝 Development Workflow

1. **Custom Themes:** Place in `./website/themes/`
2. **Custom Plugins:** Place in `./website/plugins/`
3. **Database Backups:** Automatically stored in `./database/backups/`
4. **WordPress Core:** Managed via Docker, mounted at `./website/wordpress/`

## 🔒 Security Notes

- Change default passwords in `.env` file
- Never commit `.env` file to version control
- Use strong passwords for production environments
- Regularly backup your database

## 🐛 Troubleshooting

### WordPress installation stuck
```bash
docker-compose down
docker-compose up -d
```

### Database connection issues
Check that all services are running:
```bash
docker-compose ps
```

### Reset everything
```bash
docker-compose down -v
docker-compose up -d
```

## 📚 Additional Resources

- [WordPress Documentation](https://wordpress.org/support/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [WP-CLI Documentation](https://wp-cli.org/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).