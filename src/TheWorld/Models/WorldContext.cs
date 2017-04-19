using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace TheWorld.Models
{
    public class WorldContext:DbContext //access to the database
    {
        private IConfigurationRoot _config;

        public WorldContext(IConfigurationRoot config, DbContextOptions options):base(options)
        {
            _config = config;
        }
        public DbSet<Trip> Trips { get; set; } //after creating these add services in Startup.cs
        public DbSet<Stops> Stosp { get; set; } //and in AppControler: WorldContext context

        //this method gives database option builder
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlServer(_config["ConnectionStrings:WorldContextConnection"]);
        }
    }


}
