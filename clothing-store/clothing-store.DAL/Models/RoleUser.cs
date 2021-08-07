using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class RoleUser
    {
        public RoleUser()
        {
            Users = new HashSet<Users>();
        }

        public int RoleId { get; set; }
        public string RoleName { get; set; }

        public virtual ICollection<Users> Users { get; set; }
    }
}
