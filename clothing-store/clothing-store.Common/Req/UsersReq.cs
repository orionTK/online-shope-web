namespace clothing_store.Common.Req
{
    public class UsersReq
    {
        public int Page { get; set; }
        public int Size { get; set; }
        public string Keyword { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string PassWord { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public string Dob { get; set; }
        public int RoleId { get; set; }
    }
}
