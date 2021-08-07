using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Role
    {
        public Role()
        {
            RoleUser = new HashSet<RoleUser>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Status { get; set; }

        public virtual ICollection<RoleUser> RoleUser { get; set; }
    }
}
