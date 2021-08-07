namespace clothing_store.Common.Req
{
    public class SearchReq
    {
        public int Page { get; set; }

        public int Size { get; set; }

        public int id { get; set; }

        public string Type { get; set; }

        public string Keyword { get; set; }

        public string CategoryName { get; set; }

        public bool Gender { get; set; }
    }
}
